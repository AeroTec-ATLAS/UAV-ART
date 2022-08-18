
"use strict";

let BatteryStatus = require('./BatteryStatus.js');
let ParamValue = require('./ParamValue.js');
let Mavlink = require('./Mavlink.js');
let DebugValue = require('./DebugValue.js');
let FileEntry = require('./FileEntry.js');
let HilStateQuaternion = require('./HilStateQuaternion.js');
let ESCStatus = require('./ESCStatus.js');
let GPSRTK = require('./GPSRTK.js');
let ESCTelemetryItem = require('./ESCTelemetryItem.js');
let VehicleInfo = require('./VehicleInfo.js');
let NavControllerOutput = require('./NavControllerOutput.js');
let TerrainReport = require('./TerrainReport.js');
let OnboardComputerStatus = require('./OnboardComputerStatus.js');
let WheelOdomStamped = require('./WheelOdomStamped.js');
let CompanionProcessStatus = require('./CompanionProcessStatus.js');
let MountControl = require('./MountControl.js');
let LogData = require('./LogData.js');
let ADSBVehicle = require('./ADSBVehicle.js');
let GlobalPositionTarget = require('./GlobalPositionTarget.js');
let OverrideRCIn = require('./OverrideRCIn.js');
let EstimatorStatus = require('./EstimatorStatus.js');
let WaypointReached = require('./WaypointReached.js');
let ManualControl = require('./ManualControl.js');
let ESCTelemetry = require('./ESCTelemetry.js');
let Waypoint = require('./Waypoint.js');
let RadioStatus = require('./RadioStatus.js');
let CommandCode = require('./CommandCode.js');
let PositionTarget = require('./PositionTarget.js');
let HilActuatorControls = require('./HilActuatorControls.js');
let RTKBaseline = require('./RTKBaseline.js');
let VFR_HUD = require('./VFR_HUD.js');
let Trajectory = require('./Trajectory.js');
let WaypointList = require('./WaypointList.js');
let RCIn = require('./RCIn.js');
let ESCInfoItem = require('./ESCInfoItem.js');
let LogEntry = require('./LogEntry.js');
let StatusText = require('./StatusText.js');
let HilGPS = require('./HilGPS.js');
let HilSensor = require('./HilSensor.js');
let AttitudeTarget = require('./AttitudeTarget.js');
let Param = require('./Param.js');
let CamIMUStamp = require('./CamIMUStamp.js');
let RTCM = require('./RTCM.js');
let ActuatorControl = require('./ActuatorControl.js');
let PlayTuneV2 = require('./PlayTuneV2.js');
let MagnetometerReporter = require('./MagnetometerReporter.js');
let GPSRAW = require('./GPSRAW.js');
let ExtendedState = require('./ExtendedState.js');
let State = require('./State.js');
let Tunnel = require('./Tunnel.js');
let Thrust = require('./Thrust.js');
let GPSINPUT = require('./GPSINPUT.js');
let HomePosition = require('./HomePosition.js');
let ESCStatusItem = require('./ESCStatusItem.js');
let CameraImageCaptured = require('./CameraImageCaptured.js');
let HilControls = require('./HilControls.js');
let OpticalFlowRad = require('./OpticalFlowRad.js');
let Vibration = require('./Vibration.js');
let ESCInfo = require('./ESCInfo.js');
let LandingTarget = require('./LandingTarget.js');
let RCOut = require('./RCOut.js');
let Altitude = require('./Altitude.js');
let TimesyncStatus = require('./TimesyncStatus.js');

module.exports = {
  BatteryStatus: BatteryStatus,
  ParamValue: ParamValue,
  Mavlink: Mavlink,
  DebugValue: DebugValue,
  FileEntry: FileEntry,
  HilStateQuaternion: HilStateQuaternion,
  ESCStatus: ESCStatus,
  GPSRTK: GPSRTK,
  ESCTelemetryItem: ESCTelemetryItem,
  VehicleInfo: VehicleInfo,
  NavControllerOutput: NavControllerOutput,
  TerrainReport: TerrainReport,
  OnboardComputerStatus: OnboardComputerStatus,
  WheelOdomStamped: WheelOdomStamped,
  CompanionProcessStatus: CompanionProcessStatus,
  MountControl: MountControl,
  LogData: LogData,
  ADSBVehicle: ADSBVehicle,
  GlobalPositionTarget: GlobalPositionTarget,
  OverrideRCIn: OverrideRCIn,
  EstimatorStatus: EstimatorStatus,
  WaypointReached: WaypointReached,
  ManualControl: ManualControl,
  ESCTelemetry: ESCTelemetry,
  Waypoint: Waypoint,
  RadioStatus: RadioStatus,
  CommandCode: CommandCode,
  PositionTarget: PositionTarget,
  HilActuatorControls: HilActuatorControls,
  RTKBaseline: RTKBaseline,
  VFR_HUD: VFR_HUD,
  Trajectory: Trajectory,
  WaypointList: WaypointList,
  RCIn: RCIn,
  ESCInfoItem: ESCInfoItem,
  LogEntry: LogEntry,
  StatusText: StatusText,
  HilGPS: HilGPS,
  HilSensor: HilSensor,
  AttitudeTarget: AttitudeTarget,
  Param: Param,
  CamIMUStamp: CamIMUStamp,
  RTCM: RTCM,
  ActuatorControl: ActuatorControl,
  PlayTuneV2: PlayTuneV2,
  MagnetometerReporter: MagnetometerReporter,
  GPSRAW: GPSRAW,
  ExtendedState: ExtendedState,
  State: State,
  Tunnel: Tunnel,
  Thrust: Thrust,
  GPSINPUT: GPSINPUT,
  HomePosition: HomePosition,
  ESCStatusItem: ESCStatusItem,
  CameraImageCaptured: CameraImageCaptured,
  HilControls: HilControls,
  OpticalFlowRad: OpticalFlowRad,
  Vibration: Vibration,
  ESCInfo: ESCInfo,
  LandingTarget: LandingTarget,
  RCOut: RCOut,
  Altitude: Altitude,
  TimesyncStatus: TimesyncStatus,
};
